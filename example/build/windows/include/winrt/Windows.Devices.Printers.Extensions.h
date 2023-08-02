// WARNING: Please don't edit this file. It was generated by C++/WinRT v2.0.210806.1

#pragma once
#ifndef WINRT_Windows_Devices_Printers_Extensions_H
#define WINRT_Windows_Devices_Printers_Extensions_H
#include "winrt/base.h"
static_assert(winrt::check_version(CPPWINRT_VERSION, "2.0.210806.1"), "Mismatched C++/WinRT headers.");
#define CPPWINRT_VERSION "2.0.210806.1"
#include "winrt/Windows.Devices.Printers.h"
#include "winrt/impl/Windows.Foundation.2.h"
#include "winrt/impl/Windows.Devices.Printers.Extensions.2.h"
namespace winrt::impl
{
    template <typename D> WINRT_IMPL_AUTO(hstring) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::DeviceID() const
    {
        void* value{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->get_DeviceID(&value));
        return hstring{ value, take_ownership_from_abi };
    }
    template <typename D> WINRT_IMPL_AUTO(winrt::Windows::Foundation::IInspectable) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::GetPrintModelPackage() const
    {
        void* printModelPackage{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->GetPrintModelPackage(&printModelPackage));
        return winrt::Windows::Foundation::IInspectable{ printModelPackage, take_ownership_from_abi };
    }
    template <typename D> WINRT_IMPL_AUTO(bool) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::IsPrintReady() const
    {
        bool value{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->get_IsPrintReady(&value));
        return value;
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::IsPrintReady(bool value) const
    {
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->put_IsPrintReady(value));
    }
    template <typename D> WINRT_IMPL_AUTO(winrt::event_token) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::PrintRequested(winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrintRequestedEventArgs> const& eventHandler) const
    {
        winrt::event_token eventCookie{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->add_PrintRequested(*(void**)(&eventHandler), put_abi(eventCookie)));
        return eventCookie;
    }
    template <typename D> typename consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::PrintRequested_revoker consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::PrintRequested(auto_revoke_t, winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrintRequestedEventArgs> const& eventHandler) const
    {
        return impl::make_event_revoker<D, PrintRequested_revoker>(this, PrintRequested(eventHandler));
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow<D>::PrintRequested(winrt::event_token const& eventCookie) const noexcept
    {
        WINRT_VERIFY_(0, WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow)->remove_PrintRequested(impl::bind_in(eventCookie)));
    }
    template <typename D> WINRT_IMPL_AUTO(winrt::event_token) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow2<D>::PrinterChanged(winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrinterChangedEventArgs> const& eventHandler) const
    {
        winrt::event_token eventCookie{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow2)->add_PrinterChanged(*(void**)(&eventHandler), put_abi(eventCookie)));
        return eventCookie;
    }
    template <typename D> typename consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow2<D>::PrinterChanged_revoker consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow2<D>::PrinterChanged(auto_revoke_t, winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrinterChangedEventArgs> const& eventHandler) const
    {
        return impl::make_event_revoker<D, PrinterChanged_revoker>(this, PrinterChanged(eventHandler));
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflow2<D>::PrinterChanged(winrt::event_token const& eventCookie) const noexcept
    {
        WINRT_VERIFY_(0, WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow2)->remove_PrinterChanged(impl::bind_in(eventCookie)));
    }
    template <typename D> WINRT_IMPL_AUTO(winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowStatus) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflowPrintRequestedEventArgs<D>::Status() const
    {
        winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowStatus value{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs)->get_Status(reinterpret_cast<int32_t*>(&value)));
        return value;
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflowPrintRequestedEventArgs<D>::SetExtendedStatus(winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowDetail const& value) const
    {
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs)->SetExtendedStatus(static_cast<int32_t>(value)));
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflowPrintRequestedEventArgs<D>::SetSource(winrt::Windows::Foundation::IInspectable const& source) const
    {
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs)->SetSource(*(void**)(&source)));
    }
    template <typename D> WINRT_IMPL_AUTO(void) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflowPrintRequestedEventArgs<D>::SetSourceChanged(bool value) const
    {
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs)->SetSourceChanged(value));
    }
    template <typename D> WINRT_IMPL_AUTO(hstring) consume_Windows_Devices_Printers_Extensions_IPrint3DWorkflowPrinterChangedEventArgs<D>::NewDeviceId() const
    {
        void* value{};
        check_hresult(WINRT_IMPL_SHIM(winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrinterChangedEventArgs)->get_NewDeviceId(&value));
        return hstring{ value, take_ownership_from_abi };
    }
#ifndef WINRT_LEAN_AND_MEAN
    template <typename D>
    struct produce<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow> : produce_base<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow>
    {
        int32_t __stdcall get_DeviceID(void** value) noexcept final try
        {
            clear_abi(value);
            typename D::abi_guard guard(this->shim());
            *value = detach_from<hstring>(this->shim().DeviceID());
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall GetPrintModelPackage(void** printModelPackage) noexcept final try
        {
            clear_abi(printModelPackage);
            typename D::abi_guard guard(this->shim());
            *printModelPackage = detach_from<winrt::Windows::Foundation::IInspectable>(this->shim().GetPrintModelPackage());
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall get_IsPrintReady(bool* value) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            *value = detach_from<bool>(this->shim().IsPrintReady());
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall put_IsPrintReady(bool value) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            this->shim().IsPrintReady(value);
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall add_PrintRequested(void* eventHandler, winrt::event_token* eventCookie) noexcept final try
        {
            zero_abi<winrt::event_token>(eventCookie);
            typename D::abi_guard guard(this->shim());
            *eventCookie = detach_from<winrt::event_token>(this->shim().PrintRequested(*reinterpret_cast<winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrintRequestedEventArgs> const*>(&eventHandler)));
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall remove_PrintRequested(winrt::event_token eventCookie) noexcept final
        {
            typename D::abi_guard guard(this->shim());
            this->shim().PrintRequested(*reinterpret_cast<winrt::event_token const*>(&eventCookie));
            return 0;
        }
    };
#endif
#ifndef WINRT_LEAN_AND_MEAN
    template <typename D>
    struct produce<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow2> : produce_base<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow2>
    {
        int32_t __stdcall add_PrinterChanged(void* eventHandler, winrt::event_token* eventCookie) noexcept final try
        {
            zero_abi<winrt::event_token>(eventCookie);
            typename D::abi_guard guard(this->shim());
            *eventCookie = detach_from<winrt::event_token>(this->shim().PrinterChanged(*reinterpret_cast<winrt::Windows::Foundation::TypedEventHandler<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow, winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrinterChangedEventArgs> const*>(&eventHandler)));
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall remove_PrinterChanged(winrt::event_token eventCookie) noexcept final
        {
            typename D::abi_guard guard(this->shim());
            this->shim().PrinterChanged(*reinterpret_cast<winrt::event_token const*>(&eventCookie));
            return 0;
        }
    };
#endif
#ifndef WINRT_LEAN_AND_MEAN
    template <typename D>
    struct produce<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs> : produce_base<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs>
    {
        int32_t __stdcall get_Status(int32_t* value) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            *value = detach_from<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowStatus>(this->shim().Status());
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall SetExtendedStatus(int32_t value) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            this->shim().SetExtendedStatus(*reinterpret_cast<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowDetail const*>(&value));
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall SetSource(void* source) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            this->shim().SetSource(*reinterpret_cast<winrt::Windows::Foundation::IInspectable const*>(&source));
            return 0;
        }
        catch (...) { return to_hresult(); }
        int32_t __stdcall SetSourceChanged(bool value) noexcept final try
        {
            typename D::abi_guard guard(this->shim());
            this->shim().SetSourceChanged(value);
            return 0;
        }
        catch (...) { return to_hresult(); }
    };
#endif
#ifndef WINRT_LEAN_AND_MEAN
    template <typename D>
    struct produce<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrinterChangedEventArgs> : produce_base<D, winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrinterChangedEventArgs>
    {
        int32_t __stdcall get_NewDeviceId(void** value) noexcept final try
        {
            clear_abi(value);
            typename D::abi_guard guard(this->shim());
            *value = detach_from<hstring>(this->shim().NewDeviceId());
            return 0;
        }
        catch (...) { return to_hresult(); }
    };
#endif
}
WINRT_EXPORT namespace winrt::Windows::Devices::Printers::Extensions
{
}
namespace std
{
#ifndef WINRT_LEAN_AND_MEAN
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflow2> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrintRequestedEventArgs> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::IPrint3DWorkflowPrinterChangedEventArgs> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflow> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrintRequestedEventArgs> : winrt::impl::hash_base {};
    template<> struct hash<winrt::Windows::Devices::Printers::Extensions::Print3DWorkflowPrinterChangedEventArgs> : winrt::impl::hash_base {};
#endif
}
#endif
